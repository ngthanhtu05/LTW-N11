package com.n11.sportshop.domain.dto;

import java.util.List;
import java.util.Optional;

public class ProductCriteriaDTO {

    private Optional<Integer> size;
    private Optional<Integer> page;
    private Optional<List<String>> brand;
    private Optional<List<String>> categories;
    private Optional<Integer> minPrice;
    private Optional<Integer> maxPrice;

    public Optional<List<String>> getBrand() {
        return brand;
    }

    public void setBrand(Optional<List<String>> brand) {
        this.brand = brand;
    }

    public Optional<List<String>> getCategories() {
        return categories;
    }

    public void setCategories(Optional<List<String>> categories) {
        this.categories = categories;
    }

    public Optional<Integer> getPage() {
        return page;
    }

    public void setPage(Optional<Integer> page) {
        this.page = page;
    }

    public Optional<Integer> getSize() {
        return size;
    }

    public void setSize(Optional<Integer> size) {
        this.size = size;
    }

    public Optional<Integer> getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(Optional<Integer> minPrice) {
        this.minPrice = minPrice;
    }

    public Optional<Integer> getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(Optional<Integer> maxPrice) {
        this.maxPrice = maxPrice;
    }

}
