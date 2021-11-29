package com.ss.sample.configuration.security;

import com.ss.sample.filter.CorsDevEnvironmentFilter;
import com.ss.sample.util.Constants;
import com.ss.sample.util.Constants.Roles;
import com.ss.sample.util.Constants.Urls;
import com.ss.sample.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import java.util.Arrays;
import java.util.stream.Collectors;

@EnableGlobalMethodSecurity(prePostEnabled = true)
@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	private UserDetailsService userDetailsService;

	private AuthenticationFailure authenticationFailure;
	private Environment env;

	public WebSecurityConfig(){}

	@Autowired()
	public WebSecurityConfig(@Qualifier("userDetailsService") UserDetailsService userDetailsService,
                             AuthenticationFailure authenticationFailure,
                             Environment env) {
		this.userDetailsService = userDetailsService;
		this.authenticationFailure = authenticationFailure;
		this.env = env;
	}

	// used to establish an authentication mechanism by allowing AuthenticationProviders to be added easily
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService).passwordEncoder(new BCryptPasswordEncoder());

	}

	// allows configuration of web based security at a resource level, based on a
	// selection match.  restricts the URLs
	@Override
	protected void configure(HttpSecurity http) throws Exception {

		boolean isProfileDev = Util.isProfileDev(env.getActiveProfiles());

		http
			.authorizeRequests()
				.antMatchers(Constants.Urls.ROOT, Constants.Urls.LOGIN, Constants.Urls.LOGOUT, Constants.Urls.SESSION_TIMEOUT).permitAll()

				.antMatchers("/color/**").permitAll()
				.antMatchers("/css/*.css").permitAll()
				.antMatchers("/css/**/*.css").permitAll()
				.antMatchers("/font/**").permitAll()
				.antMatchers("/ico/**").permitAll()
				.antMatchers("/img/**").permitAll()
				.antMatchers("/images/**").permitAll()
				.antMatchers("/js/*.js").permitAll()
				.antMatchers("/js/**/**").permitAll()
				.antMatchers("/webjars/**").permitAll()
				.antMatchers("/recruitment/jobSeeker/**").permitAll()

				.antMatchers(getUrlPattern(Urls.ADMIN)).access(hasRole(Roles.ADMIN_ROLE))
				.antMatchers(getUrlPattern(Urls.MANAGEMENT)).access(hasRole(Roles.MANAGEMENT_ROLE, Roles.ADMIN_ROLE))
				.antMatchers(getUrlPattern(Urls.SUPERVIZOR)).access(hasRole(Roles.SUPERVIZOR_ROLE, Roles.ADMIN_ROLE))
				.anyRequest()
				.authenticated()
				.and()
			.formLogin()
				.loginPage("/")
				.loginProcessingUrl(Urls.LOGIN)
				.failureHandler(authenticationFailure)
				.successHandler(successHandler())
				.permitAll()
				.and()
			.exceptionHandling()
//				.authenticationEntryPoint(new EntryPointUnauthorizedHandler())
				.authenticationEntryPoint(new LoginUrlAuthenticationEntryPoint("/"))
				.accessDeniedPage(Urls.ACCESS_DENIED)
//				.and().sessionManagement().invalidSessionUrl(Urls.SESSION_TIMEOUT)
//				.and().sessionManagement().invalidSessionUrl(Urls.ACCESS_DENIED)
				.and()
			.logout()
//				.logoutUrl("/logout")
				.addLogoutHandler(customLogoutHandler())
				.logoutRequestMatcher(new AntPathRequestMatcher(Urls.LOGOUT))
				.permitAll()
				;

		if(isProfileDev) {
			http.csrf().disable().addFilterBefore(new CorsDevEnvironmentFilter(), CsrfFilter.class);
		}
	}

	// is used for configuration settings that impact global security (ignore resources,
	// set debug mode, reject requests by implementing a custom firewall definition).
	// For example, the following method would cause any request that starts with /resources/ to be ignored for authentication purposes.

	@Override
	public void configure(WebSecurity web) throws Exception {
			web
				.ignoring()
				.antMatchers("/resources/**");
	}

	@Bean
	public AuthenticationSuccessHandler successHandler() {
		AuthenticationSuccess handler = new AuthenticationSuccess();
		handler.setUseReferer(true);
		return handler;
	}

	@Bean
	public LogoutSuccess logoutSucessHandler() {
		return new LogoutSuccess();
	}

	@Bean
	public CustomLogoutHandler customLogoutHandler() {
		return new CustomLogoutHandler();
	}

	// Appends ** to end of given string
	public String getUrlPattern(String s) {
		return s + "**";
	}

	String hasRole(String... roles){

		if(roles.length == 0){
			throw new IllegalArgumentException("At least one role should be passed");
		} else if(roles.length == 1){
			return "hasRole('" + "ROLE_" + roles[0] + "')";
		} else {

			String s = Arrays.stream(roles)
					.map(role -> "'" + "ROLE_" + role + "'")
					.collect(Collectors.joining(", "));

			return "hasAnyRole(" + s + ")";
		}
	}
}