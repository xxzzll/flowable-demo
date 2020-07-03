package com.meishi.flowable.handler;

import org.flowable.engine.ProcessEngine;
import org.flowable.engine.ProcessEngineConfiguration;
import org.flowable.engine.impl.cfg.StandaloneProcessEngineConfiguration;

/**
 * @author lizhenxi
 * @create 2020-05-29-16:31
 * @description 请假请求
 */
public class HolidayRequest {

    /**
     * 1. 需要实例化 工作流引擎 ProcessEngine (线程安全的，一个应用只有一个)
     * 2. 通过 ProcessEngineConfiguration 构建一个最小化的 工作流引擎，只需配置数据库连接
     * 3. 在 Spring 环境下，使用 SpringProcessEngineConfiguration  替代 StandaloneProcessEngineConfiguration
     * 4. setDatabaseSchemaUpdate(ProcessEngineConfiguration.DATABASE_TYPE_MYSQL) 确保 schema 不存在的情况下自动创建
     *
     */
    public static void main(String[] args) {
        ProcessEngineConfiguration cfg = new StandaloneProcessEngineConfiguration()
                .setJdbcUrl("jdbc:mysql://192.168.1.118:3306/flowable-test?characterEncoding=UTF-8&useSSL=false")
                .setJdbcUsername("root")
                .setJdbcPassword("Lzx@123456")
                .setJdbcDriver("com.mysql.jdbc.Driver")
                .setDatabaseSchemaUpdate(ProcessEngineConfiguration.DATABASE_TYPE_MYSQL);

        ProcessEngine processEngine = cfg.buildProcessEngine();

        System.out.println(processEngine);
    }

}