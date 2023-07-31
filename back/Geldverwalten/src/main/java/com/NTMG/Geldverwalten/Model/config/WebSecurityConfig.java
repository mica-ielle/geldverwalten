package com.NTMG.Geldverwalten.Model.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	private JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;

	private UserDetailsService jwtUserDetailsService;

	@Autowired
	private JwtRequestFilter jwtRequestFilter;

	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth, JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint, UserDetailsService jwtUserDetailsService) throws Exception {
		this.jwtAuthenticationEntryPoint=jwtAuthenticationEntryPoint;
		this.jwtUserDetailsService=jwtUserDetailsService;
		// configure AuthenticationManager so that it knows from where to load
		// user for matching credentials
		// Use BCryptPasswordEncoder

		/*auth.inMemoryAuthentication()
				.withUser("admin")
				.password("{bcrypt}$2a$10$6CW1agMzVzBhxDzK0PcxrO/cQcmN9h8ZriVEPy.6DJbVeyATG5mWe")
				.roles("ADMIN");*/
		auth.userDetailsService(jwtUserDetailsService).passwordEncoder(passwordEncoder());
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	@Override
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}

	@Override
	protected void configure(HttpSecurity httpSecurity) throws Exception {
		// We don't need CSRF for this example
		httpSecurity.csrf().disable().cors(Customizer.withDefaults())
				// dont authenticate this particular request
				.authorizeRequests()
				.antMatchers("/login", "/register").permitAll()
				.antMatchers("/createProjet").permitAll()
				.antMatchers("/addEntree").permitAll()
				.antMatchers("/addSortie/{id}").permitAll()
				.antMatchers("/nbProjet").permitAll()
				.antMatchers("/updateSortie/{id}").permitAll()
				.antMatchers("/deleteProjet/{id}").permitAll()
				.antMatchers("/solde").permitAll()
				.antMatchers("/getEntree").permitAll()
				.antMatchers("/getSortie").permitAll()
				.antMatchers("/getProjet/{id}").permitAll()
				// all other requests need to be authenticated
				.anyRequest().authenticated().and().
				// make sure we use stateless session; session won't be used to
				// store user's state.
				exceptionHandling().authenticationEntryPoint(jwtAuthenticationEntryPoint).and().sessionManagement()
				.sessionCreationPolicy(SessionCreationPolicy.STATELESS);

		// Add a filter to validate the tokens with every request
		httpSecurity.addFilterBefore(jwtRequestFilter, UsernamePasswordAuthenticationFilter.class);
	}
}