package com.ss.sample.model.recruitment;

import lombok.Builder;
import lombok.Data;

@Data
@Builder(toBuilder = true)
public class Status {
    private String responseText;
    private boolean status;
}
