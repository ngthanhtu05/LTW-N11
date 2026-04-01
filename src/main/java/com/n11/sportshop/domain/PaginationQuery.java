package com.n11.sportshop.domain;

import org.springframework.data.domain.Page;

public class PaginationQuery<T> {
    private int page;
    private Page<T> prs;

    public PaginationQuery(int page, Page<T> prs) {
        this.page = page;
        this.prs = prs;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public Page<T> getPrs() {
        return prs;
    }

    public void setPrs(Page<T> prs) {
        this.prs = prs;
    }

}
