package com.qcz.qmplatform.module.business.other.domain.qo;

import lombok.Data;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@Accessors(chain = true)
public class BillQO implements Serializable {

    private String remark;

    private String consumer;

    private String typeId;

    private LocalDateTime consumeTimeStart;

    private LocalDateTime consumeTimeEnd;

}
