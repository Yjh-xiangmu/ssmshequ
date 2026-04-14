package com.ssmshequ.entity;

import org.springframework.format.annotation.DateTimeFormat;
import java.math.BigDecimal;
import java.util.Date;

public class Drug {
    private Integer id;
    private String name;
    private String category;
    private String spec;
    private String unit;
    private Integer stock;
    private BigDecimal price;
    private String manufacturer;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date expireDate;

    private String remark;

    // 新增字段：成分与用法
    private String ingredients;
    private String usageInfo;

    // --- Getter and Setter ---

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getSpec() { return spec; }
    public void setSpec(String spec) { this.spec = spec; }

    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }

    public Integer getStock() { return stock; }
    public void setStock(Integer stock) { this.stock = stock; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public String getManufacturer() { return manufacturer; }
    public void setManufacturer(String manufacturer) { this.manufacturer = manufacturer; }

    public Date getExpireDate() { return expireDate; }
    public void setExpireDate(Date expireDate) { this.expireDate = expireDate; }

    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }

    public String getIngredients() { return ingredients; }
    public void setIngredients(String ingredients) { this.ingredients = ingredients; }

    public String getUsageInfo() { return usageInfo; }
    public void setUsageInfo(String usageInfo) { this.usageInfo = usageInfo; }
}