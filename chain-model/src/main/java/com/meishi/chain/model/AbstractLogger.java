package com.meishi.chain.model;

/**
 * @author lizhenxi
 * @create 2020-06-30-18:33
 * @description
 */
public abstract class AbstractLogger implements Logger {
    /**
     * 下一个节点
     */
    protected Logger next;
    /**
     * 日志配置等级
     */
    protected int configLevel;

    public AbstractLogger(int configLevel) throws Exception{
        if (configLevel > 4 || configLevel < 1) {
            throw new Exception("Unsupported logger config level, only 1 to 4 is allowed!");
        }else{
            this.configLevel = configLevel;
        }
    }

    @Override
    public Logger getNext() {
        return next;
    }

    @Override
    public void setNext(Logger logger) throws Exception {
        this.next = logger;
    }

    /**
     * 提供给子类的公共方法
     * @param message
     * @return
     */
    protected void print(String message) {
        System.out.println(message);
    }
}
