package com.meishi.chain.model;

/**
 * @author lizhenxi
 * @create 2020-06-30-18:41
 * @description
 */
public class WarnLogger extends AbstractLogger {
    /**
     * 定义本日志级别
     */
    private static final int level = 3;

    public WarnLogger(int configLevel) throws Exception {
        super(configLevel);
    }

    @Override
    public void excute(String message, int msgLevel) throws Exception {
        if (msgLevel == level) {
            print("Logger::Warn: " + message);
        }else{
            next.excute(message, msgLevel);
        }
    }
}
