package com.meishi.chain.model;

/**
 * @author lizhenxi
 * @create 2020-06-30-18:38
 * @description
 */
public class ErrorLogger extends AbstractLogger {
    /**
     * 定义当前日志等级
     */
    private static final int level = 4;

    public ErrorLogger(int configLevel) throws Exception {
        super(configLevel);
    }

    @Override
    public void excute(String message, int msgLevel) throws Exception {
        if (msgLevel == level) {
            print("Logger::Error: " + message);
        }else{
            // 传递给下一个节点处理
            next.excute(message, msgLevel);
        }
    }
}
