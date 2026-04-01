package com.n11.sportshop.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "Category")
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    
    private int id;
    private String code;
    @Column(nullable = false, columnDefinition = "INT DEFAULT 1")
    private Integer status = 1;
    public String getCode() {
        return code;
    }
    public void setCode(String code) {
        this.code = code;
    }
    private String name;
    public int getId() {
        return id;
    }
    public void setId(int categoryId) {
        this.id = categoryId;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public Integer getStatus() {
        return status;
    }
    public void setStatus(Integer status) {
        this.status = status;
    }

   
   
}
