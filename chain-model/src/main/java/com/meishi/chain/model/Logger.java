package com.meishi.chain.model;

/**
 * @author lizhenxi
 * @create 2020-06-30-18:32
 * @description
 */
public interface Logger {
    /**
     * 打印日志的方法
     * @param message  具体内容
     * @param msgLevel 日志级别
     * @throws Exception 当打印消息的日志级别不在范围内时抛出异常
     */
    void excute(String message, int msgLevel) throws Exception;

    /**
     * 获取日志类的下一个节点
     * @return
     */
    Logger getNext();

    /**
     * 设置日志类的下一个节点，以形成责任链
     * @param logger
     * @throws Exception
     */
    void setNext(Logger logger) throws Exception;
}
