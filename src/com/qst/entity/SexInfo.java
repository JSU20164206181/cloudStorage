package com.qst.entity;

import org.springframework.stereotype.Component;

import java.io.Serializable;

/**
 * @Auther: CGL
 * @Date: 2019/9/10 10:13
 * @Description:
 */
public class SexInfo implements Serializable {

    private int sum;
    private int manNum;
    private int woMn;

    @Override
    public String toString() {
        return "SexInfo{" +
                "sum=" + sum +
                ", manNum=" + manNum +
                ", woMn=" + woMn +
                '}';
    }

    public int getSum() {
        return sum;
    }

    public void setSum(int sum) {
        System.out.println("sum注入"+sum);
        this.sum = sum;
    }

    public int getManNum() {
        return manNum;
    }

    public void setManNum(int manNum) {
        System.out.println("manNum注入"+manNum);
        this.manNum = manNum;
    }

    public int getWoMn() {
        return woMn;
    }

    public void setWoMn(int woMn) {
        System.out.println("woManNum注入"+woMn);
        this.woMn = woMn;
    }
}
