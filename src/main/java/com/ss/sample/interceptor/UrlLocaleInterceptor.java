package com.ss.sample.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Locale;

@Component
public class UrlLocaleInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);

		if(localeResolver == null) {
			throw new IllegalStateException("No Local Resolver Found");
		}

		Locale locale = localeResolver.resolveLocale(request);
		localeResolver.setLocale(request, response, locale);

		return true;
	}
}
