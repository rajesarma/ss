package com.ss.sample.configuration;

import com.ss.sample.util.JsonUtil;
import io.micrometer.core.instrument.util.JsonUtils;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.StopWatch;
import org.springframework.web.servlet.mvc.method.annotation.ExtendedServletRequestDataBinder;

import javax.servlet.http.HttpServletResponseWrapper;
import java.text.NumberFormat;
import java.util.*;

@Configuration
@Aspect
@Slf4j(topic = "PROFILING")
public class ProfilingInterceptor {
    @Value("${profiling.enabled:false}")
    @Setter
    private boolean enableProfiling;

    static class StopWatchHierarchy {
        private static final ThreadLocal<StopWatchHierarchy> stopWatchLocal = new ThreadLocal<>();
        private static final IndentStack indentStack = new IndentStack();
        static StopWatchHierarchy getInstance(String id) {
            StopWatchHierarchy stopWatch = stopWatchLocal.get();
            if(stopWatch == null) {
                stopWatch = new StopWatchHierarchy(id);
                stopWatchLocal.set(stopWatch);
            }
            return stopWatch;
        }
        static void reset() {
            stopWatchLocal.remove();
        }

        final StopWatch stopWatch;
        final Stack stack;
        StopWatchHierarchy(String id) {
            stopWatch = new StopWatch(id);
            stack = new Stack();
        }

        void start(String taskName) {
            if (stopWatch.isRunning()) {
                stopWatch.stop();
            }
            taskName = indentStack.get(stack.size) + taskName;
            stack.push(taskName);
            stopWatch.start(taskName);
        }

        void stop() {
            stopWatch.stop();
            stack.pop();
            if (stack.isEmpty()) {
                log.info(print(stopWatch));
                StopWatchHierarchy.reset();
            } else {
                stopWatch.start(stack.get());
            }
        }
    }

    @Around("execution(* com.ss.sample..*.*(..)) " +
            "&& !execution(* com.ss.sample.filter.CookieFilter.*(..))" +
            "&& !execution(* com.ss.sample.filter.UrlSessionFilter.*(..))" +
            "&& !execution(* com.ss.sample.util.DBUtils.*(..))" +
            "&& !execution(* com.ss.sample.configuration.WebConfig.*(..))" +
            "&& !execution(* com.ss.sample.configuration.TilesConfiguration.*(..))" +
            "&& !execution(* com.ss.sample.configuration.security.WebSecurityConfig.*(..))"
//            + "&& !within(com.ss.sample.configuration.security.*) " for package
    )
    public Object invoke(ProceedingJoinPoint invocation) throws Throwable {
        if (enableProfiling) {
            MethodSignature methodSignature = (MethodSignature) invocation.getSignature();
            String className = methodSignature.getDeclaringType().getSimpleName();
            String methodName = methodSignature.getName();
            String stopWatchName = className + "->" + methodName;
            StopWatchHierarchy stopWatch = StopWatchHierarchy.getInstance(stopWatchName);
            String taskName = invocation.getSignature().toString().replace("com.ss.sample.", "");
            stopWatch.start(taskName);
            try {
                return invocation.proceed();
            } finally {
                stopWatch.stop();
            }
        } else {
            return invocation.proceed();
        }
    }

    public void around(ProceedingJoinPoint p) throws Throwable {
        String uuid = UUID.randomUUID().toString().replace("-","");
        log.info(beforeMethod(p, uuid));
        try {
            Object proceed = p.proceed();
            methodAfterReturning(proceed, uuid);
        } catch (Exception e) {
            log.error("[{}]Response Exception content: {}", uuid, e);
            throw e;
        }
    }

    public static String summary(StopWatch stopWatch) {
        return "StopWatch '" + stopWatch.getId() + "': running time = " + stopWatch.getTotalTimeMillis() + " ms";
    }

    public static String print(StopWatch stopWatch) {
        StringBuilder sb = new StringBuilder();
        sb.append('\n');
        sb.append(summary(stopWatch));
        sb.append('\n');
        sb.append("----------------------------------------\n");
        sb.append("ms(").append(stopWatch.getTotalTimeMillis()).append(")           %      Task name\n");
        sb.append("----------------------------------------\n");
        NumberFormat nf = NumberFormat.getNumberInstance();
        nf.setMinimumIntegerDigits(9);
        nf.setGroupingUsed(false);

        NumberFormat pf = NumberFormat.getPercentInstance();
        pf.setMinimumIntegerDigits(3);
        pf.setGroupingUsed(false);
        for (StopWatch.TaskInfo task : stopWatch.getTaskInfo()) {
            sb.append(nf.format(task.getTimeMillis())).append(" ");
            sb.append(pf.format((double) task.getTimeMillis() / stopWatch.getTotalTimeMillis())).append(" ");
            sb.append(task.getTaskName()).append("\n");
        }
        return sb.toString();
    }



    static class Stack {
        private int size = 0;
        String[] elements;
        public Stack() {elements = new String[10]; }
        public void push (String e) {
            if (size == elements.length) {
                copy();
            }
            elements[size++] = e;
        }

        public String pop() {
            String e = elements[--size];
            elements[size] = null;
            return e;
        }

        public String get() { return elements[size - 1]; }
        public boolean isEmpty() { return size == 0; }

        private void copy () {
            int newSize = elements.length * 2;
            elements = Arrays.copyOf(elements, newSize);
        }
    }

    static class IndentStack {
        String[] elements = new String[0];
        public String get(int index) {
            if(index >= elements.length) {
                copy(index + 10);
            }
            return elements[index];
        }
        private void copy(int newSize) {
            int oldSize = elements.length;
            elements = Arrays.copyOf(elements, newSize);
            for (int i = oldSize; i< elements.length; i++) {
                elements[i] = new String(new char[i]).replace("\0", "|   ");
            }
        }
    }

    private String beforeMethod(JoinPoint joinPoint, String uuid) {
        String result = "";
        try {
            Object[] objs = joinPoint.getArgs();
            String[] argNames = ((MethodSignature) joinPoint.getSignature()).getParameterNames();
            Map<String, Object> paramMap = new HashMap<>();
            for (int i = 0; i < objs.length; i++) {
                if (!(objs[i] instanceof ExtendedServletRequestDataBinder) && !(objs[i] instanceof HttpServletResponseWrapper)) {
                    paramMap.put(argNames[i], objs[i]);
                }
            }
            if(paramMap.size() > 0) {
                result += "["+uuid+"]method:"+joinPoint.getSignature()+"|| parameter:"+ JsonUtil.objectToJson(paramMap);
            } else {
                result += "["+uuid+"]method:"+joinPoint.getSignature();
            }
        } catch (Exception e) {
            log.error("[{}] AOP beforeMethod", uuid, e);
            result = "[ERROR]";
        }
        return result;
    }

    private void methodAfterReturning(Object o, String uuid) {
        try {
            if(o != null) {
                log.info("[{}]Response content:{}", uuid, JsonUtil.objectToJson(o));
            }
        } catch (Exception e) {
            log.error("[{}]AOP methodAfterReturning", uuid, e);
        }
    }
}
