package com.n11.sportshop.domain.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

public class InformationDTO {

    // @NotBlank(message = "Tên không được để trống")
    private String name;

    // @Pattern(regexp = "^(0|\\+84)[0-9]{9}$", message = "Số điện thoại không hợp
    // lệ")
    private String phone;

    // @Email(message = "Email không hợp lệ")
    // @NotBlank(message = "Email không được để trống")
    private String email;

    // @NotBlank(message = "Địa chỉ không được để trống")
    private String address;

    private String note;
    private String payment; // CASH hay VNPAY
    private String voucherCode;
    private Long totalPrice; // Tao ma qr
    private String paymentRef;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public Long getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Long totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getPaymentRef() {
        return paymentRef;
    }

    public void setPaymentRef(String paymentRef) {
        this.paymentRef = paymentRef;
    }

}
