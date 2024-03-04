package com.modifyk.accountbook.member;

import java.util.concurrent.Executor;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.AsyncConfigurerSupport;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

@Configuration
@EnableAsync
public class AsyncConfig extends AsyncConfigurerSupport {

    public Executor getAsyncExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(2); // 실행 대기 중인 Thread 개수
        executor.setMaxPoolSize(5); // 동시에 동작하는 최대 Thread 개수
        executor.setQueueCapacity(10);// CorePool이 초과될때 Queue에 저장했다가 꺼내서 실행
        executor.setThreadNamePrefix("Async Mail-");
        executor.initialize();
        return executor;
    }
}