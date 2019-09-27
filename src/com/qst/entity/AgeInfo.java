package com.qst.entity;

import java.io.Serializable;

/**
 * @Auther: CGL
 * @Date: 2019/9/10 16:34
 * @Description:  年龄类对象
 */
public class AgeInfo implements Serializable {

    private Integer child;
    private Integer young;
    private Integer youth;
    private Integer middle;
    private Integer old;
    private Integer sum;

    public Integer getSum() {
        return sum;
    }

    public void setSum(Integer sum) {
        this.sum = sum;
    }



    @Override
    public String toString() {
        return "AgeInfo{" +
                "child=" + child +
                ", young=" + young +
                ", youth=" + youth +
                ", middle=" + middle +
                ", old=" + old +
                '}';
    }

    public Integer getChild() {
        return child;
    }

    public void setChild(Integer child) {
        this.child = child;
    }

    public Integer getYoung() {
        return young;
    }

    public void setYoung(Integer young) {
        this.young = young;
    }

    public Integer getYouth() {
        return youth;
    }

    public void setYouth(Integer youth) {
        this.youth = youth;
    }

    public Integer getMiddle() {
        return middle;
    }

    public void setMiddle(Integer middle) {
        this.middle = middle;
    }

    public Integer getOld() {
        return old;
    }

    public void setOld(Integer old) {
        this.old = old;
    }
}
