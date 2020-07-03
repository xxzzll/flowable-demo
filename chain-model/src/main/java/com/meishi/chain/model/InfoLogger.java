package com.meishi.chain.model;

/**
 * @author lizhenxi
 * @create 2020-06-30-18:43
 * @description
 */
public class InfoLogger extends AbstractLogger {
    /**
     * 定义本日志级别
     */
    private static final int level = 2;

    public InfoLogger(int configLevel) throws Exception {
        super(configLevel);
    }

    @Override
    public void excute(String message, int msgLevel) throws Exception {
        if (msgLevel == level) {
            print("Logger::Info: " + message);
        }else{
            next.excute(message, msgLevel);
        }
    }
}
