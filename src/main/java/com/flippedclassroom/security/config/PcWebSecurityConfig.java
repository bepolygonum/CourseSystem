package com.flippedclassroom.security.config;

import com.flippedclassroom.security.UserDetailsServiceImpl;
import com.flippedclassroom.security.entrypoint.LoginEntryPoint;
import com.flippedclassroom.security.handler.IdentityCheckFailureHandler;
import com.flippedclassroom.security.handler.IdentityCheckSuccessHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;



/**
 * @author KEKE
 */
@Configuration
@Order(2)
public class PcWebSecurityConfig extends WebSecurityConfigurerAdapter {
    private final UserDetailsServiceImpl userDetailsServiceImp;
    private final IdentityCheckSuccessHandler identityCheckSuccessHandler;
    private final IdentityCheckFailureHandler identityCheckFailureHandler;
    private final LoginEntryPoint loginEntryPoint;

    @Autowired
    public PcWebSecurityConfig(UserDetailsServiceImpl userDetailsServiceImp, IdentityCheckSuccessHandler identityCheckSuccessHandler,
                               IdentityCheckFailureHandler identityCheckFailureHandler,LoginEntryPoint loginEntryPoint)
    {
        this.userDetailsServiceImp=userDetailsServiceImp;
        this.identityCheckSuccessHandler=identityCheckSuccessHandler;
        this.identityCheckFailureHandler=identityCheckFailureHandler;
        this.loginEntryPoint=loginEntryPoint;
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsServiceImp);
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/static/**");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/static/css/**","/static/**", "/static/js/**","/static/img/**","/static/fonts/**").permitAll()
                .antMatchers("/login").permitAll()
                .antMatchers("/forgetPassword").permitAll()
                .antMatchers("/send").permitAll()
                .antMatchers("/findPwd").permitAll()
                .anyRequest()
                .authenticated()
                .antMatchers( "/studentpc").hasRole("STUDENT")
                .antMatchers("/teacherpc").hasRole("TEACHER")
                .and().formLogin().loginPage("/login")
                .loginProcessingUrl("/index")
                .usernameParameter("account").passwordParameter("password")
                .successHandler(identityCheckSuccessHandler)
                .failureHandler(identityCheckFailureHandler)
                .failureUrl("/login?error")
                .permitAll()
                .and()
                .logout().logoutUrl("/pc/logout").logoutSuccessUrl("/pc/login")
                .permitAll().and().csrf().disable()
                .headers().frameOptions().sameOrigin()
                .and()
                .exceptionHandling().authenticationEntryPoint(loginEntryPoint);
    }
}
