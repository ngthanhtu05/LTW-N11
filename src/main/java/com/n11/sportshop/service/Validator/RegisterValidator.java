package com.n11.sportshop.service.Validator;

import org.springframework.stereotype.Service;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import com.n11.sportshop.domain.dto.RegisterDTO;
import com.n11.sportshop.service.UserService;

@Service
public class RegisterValidator implements ConstraintValidator<RegisterChecked, RegisterDTO> {
    // RegisterDTO là kiểu dữ liệu đc kiểm tra
    private final UserService userService;

    public RegisterValidator(UserService userService) {
        this.userService = userService;
    }

    @Override
    public boolean isValid(RegisterDTO user, ConstraintValidatorContext context) {
        boolean valid = true;

        // Check if password fields match
        if (!user.getPassword().equals(user.getConfirmPassword())) {
            context.buildConstraintViolationWithTemplate("Mật khẩu nhập không chính xác")
                    .addPropertyNode("confirmPassword")
                    // addPropertyNode("confirmPassword"): Lỗi sẽ được áp dụng vào trường
                    // confirmPassword trong đối tượng RegisterDTO.
                    // Điều này có nghĩa là lỗi sẽ liên kết với trường confirmPassword, không phải
                    // với password hay email.
                    .addConstraintViolation() // ?
                    .disableDefaultConstraintViolation();
            // Dùng để tắt thông báo lỗi mặc định, chỉ hiển thị thông báo tùy chỉnh do ta
            // định nghĩa.
            valid = false;
        }

        // Additional validations can be added here
        // check email có từng tồn tại hay không
        if (this.userService.checkEmailExist(user.getEmail())) {
            context.buildConstraintViolationWithTemplate("Email đã tồn tại")
                    .addPropertyNode("email")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        // check username có tồn tại hay không
        if (this.userService.checkUsernameExist(user.getUsername())) {
            context.buildConstraintViolationWithTemplate("Tên đăng nhập đã tồn tại")
                    .addPropertyNode("username")
                    .addConstraintViolation()
                    .disableDefaultConstraintViolation();
            valid = false;
        }

        return valid;
    }
}