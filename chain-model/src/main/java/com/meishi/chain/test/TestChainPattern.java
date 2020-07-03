package com.meishi.chain.test;

import com.meishi.chain.model.*;

/**
 * @author lizhenxi
 * @create 2020-06-30-18:32
 * @description
 */
public class TestChainPattern {
    /**
     * 设置的系统的日志级别，组合日志处理责任链，返回责任链的首个节点
     * @param level 系统的日志级别
     * @return
     * @throws Exception
     */
    public static Logger initLogConfig(int level) throws Exception {
        try{
            Logger root = new ErrorLogger(level);
            Logger warnLogger = new WarnLogger(level);
            Logger infoLogger = new InfoLogger(level);
            Logger debugLogger = new DebugLogger(level);

            root.setNext(warnLogger);
            warnLogger.setNext(infoLogger);
            infoLogger.setNext(debugLogger);
            return root;
        }catch (Exception e){
            throw e;
        }
    }

    public static void main(String[] args) {
        try{
            Logger logger = initLogConfig(4);

            logger.excute("error message", 4);
            logger.excute("warn message", 3);
            logger.excute("info message", 2);
            logger.excute("debug message", 1);
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
    }
}
