package com.qcz.qmplatform.module.other.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * <p>
 * 账单
 * </p>
 *
 * @author quchangzhong
 * @since 2022-08-09
 */
@TableName("tbl_bill")
public class Bill implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 账单id
     */
    @TableId("id")
    private String id;

    /**
     * 账单类型id
     */
    @TableField("type_id")
    private String typeId;

    /**
     * 金额
     */
    @TableField("amount")
    private BigDecimal amount;

    /**
     * 消费人
     */
    @TableField("consumer")
    private String consumer;

    /**
     * 备注
     */
    @TableField("remark")
    private String remark;

    /**
     * 消费日期
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @TableField("consume_time")
    private Timestamp consumeTime;

    /**
     * 账单创建时间
     */
    @TableField("create_time")
    private Timestamp createTime;

    /**
     * 账单创建人id
     */
    @TableField("create_user_id")
    private String createUserId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTypeId() {
        return typeId;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getConsumer() {
        return consumer;
    }

    public void setConsumer(String consumer) {
        this.consumer = consumer;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Timestamp getConsumeTime() {
        return consumeTime;
    }

    public void setConsumeTime(Timestamp consumeTime) {
        this.consumeTime = consumeTime;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public String getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(String createUserId) {
        this.createUserId = createUserId;
    }

    @Override
    public String toString() {
        return "Bill{" +
                "id=" + id +
                ", typeId=" + typeId +
                ", amount=" + amount +
                ", consumer=" + consumer +
                ", remark=" + remark +
                ", consumeTime=" + consumeTime +
                ", createTime=" + createTime +
                ", createUserId=" + createUserId +
                "}";
    }
}
