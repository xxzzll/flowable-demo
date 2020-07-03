package com.meishi.chain.model;

/**
 * @author lizhenxi
 * @create 2020-06-30-18:44
 * @description
 */
public class DebugLogger extends AbstractLogger {
    /**
     * 定义本日志级别
     */
    private static final int level = 1;

    public DebugLogger(int configLevel) throws Exception {
        super(configLevel);
    }

    @Override
    public void excute(String message, int msgLevel) throws Exception {
        if (msgLevel == level) {
            print("Logger::Debug: " + message);
        }
    }

    /**
     * 最后一个节点，没有下一个节点
     * @return
     */
    @Override
    public Logger getNext() {
        return null;
    }

    /**
     * 不支持设置下一个节点方法
     * @param logger
     * @throws Exception
     */
    @Override
    public void setNext(Logger logger) throws Exception {
        throw new Exception("Next Logger not allowed in here!");
    }
}
