package com.meishi.flowable.handler;

import org.flowable.engine.ProcessEngine;
import org.flowable.engine.ProcessEngineConfiguration;
import org.flowable.engine.impl.cfg.StandaloneProcessEngineConfiguration;

/**
 * @author lizhenxi
 */
public class HolidayRequest {

    public static void main(String[] args) {
        ProcessEngineConfiguration cfg = new StandaloneProcessEngineConfiguration()
                .setJdbcUrl("jdbc:mysql://localhost:3306/flowable-spring-boot?characterEncoding=UTF-8&useSSL=false")
                .setJdbcUsername("root")
                .setJdbcPassword("Lzx@123456")
                .setJdbcDriver("com.mysql.jdbc.Driver")
                .setDatabaseSchemaUpdate(ProcessEngineConfiguration.DATABASE_TYPE_MYSQL);

        ProcessEngine processEngine = cfg.buildProcessEngine();

        System.out.println(processEngine);
    }

}