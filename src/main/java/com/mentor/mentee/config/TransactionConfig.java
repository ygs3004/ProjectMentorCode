package com.mentor.mentee.config;


import java.util.Collections;
import java.util.HashMap;

import org.aspectj.lang.annotation.Aspect;
import org.springframework.aop.Advisor;
import org.springframework.aop.aspectj.AspectJExpressionPointcut;
import org.springframework.aop.support.DefaultPointcutAdvisor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.interceptor.NameMatchTransactionAttributeSource;
import org.springframework.transaction.interceptor.RollbackRuleAttribute;
import org.springframework.transaction.interceptor.RuleBasedTransactionAttribute;
import org.springframework.transaction.interceptor.TransactionAttribute;
import org.springframework.transaction.interceptor.TransactionInterceptor;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Aspect
@Configuration
@RequiredArgsConstructor
public class TransactionConfig {

    private final PlatformTransactionManager transactionManager;

    TransactionInterceptor transactionAdvice() {
        TransactionInterceptor txAdvice = new TransactionInterceptor();
        NameMatchTransactionAttributeSource txAttributeSource = new NameMatchTransactionAttributeSource();
        RuleBasedTransactionAttribute txAttribute = new RuleBasedTransactionAttribute();

        txAttribute.setRollbackRules(Collections.singletonList(new RollbackRuleAttribute(Exception.class)));
        txAttribute.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

        HashMap<String, TransactionAttribute> txMethods = new HashMap<String, TransactionAttribute>();
        txMethods.put("*", txAttribute);
        txAttributeSource.setNameMap(txMethods);

        txAdvice.setTransactionAttributeSource(txAttributeSource);
        txAdvice.setTransactionManager(transactionManager);

        return txAdvice;
    }

    @Bean
    Advisor transactionAdviceAdvisor() {
        log.debug("transactionAdviceAdvisor()");
        AspectJExpressionPointcut pointcut = new AspectJExpressionPointcut();
        pointcut.setExpression("execution(* com.mentor.mentee.service..*Service.*(..))");
        return new DefaultPointcutAdvisor(pointcut, transactionAdvice());
    }

}