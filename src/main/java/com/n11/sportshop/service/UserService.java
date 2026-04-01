package com.n11.sportshop.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.n11.sportshop.domain.Role;
import com.n11.sportshop.domain.User;
import com.n11.sportshop.domain.UserVoucher;
import com.n11.sportshop.domain.Voucher;
import com.n11.sportshop.domain.dto.RegisterDTO;
import com.n11.sportshop.repository.RoleRepository;
import com.n11.sportshop.repository.UserRepository;
import com.n11.sportshop.repository.UserVoucherRepo;
import com.n11.sportshop.repository.VoucherRepository;

import jakarta.transaction.Transactional;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final ImageService imageService;
    private final PasswordEncoder passwordEncoder;
    private final UserVoucherRepo userVoucherRepo;
    private final VoucherRepository voucherRepository;
    

    public UserService(UserRepository userRepository, RoleRepository roleRepository, ImageService imageService,
            PasswordEncoder passwordEncoder, UserVoucherRepo userVoucherRepo, VoucherRepository voucherRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.imageService = imageService;
        this.passwordEncoder = passwordEncoder;
        this.userVoucherRepo = userVoucherRepo;
        this.voucherRepository = voucherRepository;
    }

    public void createUserByClient(RegisterDTO userDTO) {
        User user = new User();
        user.setFullName(userDTO.getFirstName() + " " + userDTO.getLastName());
        user.setUsername(userDTO.getUsername());
        user.setEmail(userDTO.getEmail());
        user.setPassword(passwordEncoder.encode(userDTO.getPassword()));
        user.setRole(this.roleRepository.findByName("USER"));
        String imageName = "defaultavatar.jpg";
        user.setImage(imageName);
        User savedUser = this.userRepository.save(user);

        // Gán voucher “WELCOME10” mặc định cho user mới
        Voucher welcomeVoucher = voucherRepository.findByCode("WELCOME10");
        if (welcomeVoucher != null) {
            UserVoucher userVoucher = new UserVoucher();
            userVoucher.setUser(savedUser);
            userVoucher.setVoucher(welcomeVoucher);
            userVoucher.setQuantity(1);
            userVoucherRepo.save(userVoucher);
        }
    }

    public void createUserByAdmin(User user, MultipartFile file) {
        Role roleInDataBase = this.roleRepository.findByName(user.getRole().getName());
        user.setRole(roleInDataBase);
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        String imageName = "defaultavatar.jpg";
        if (file != null && !file.isEmpty()) {
            // Nếu người dùng có upload ảnh
            imageName = this.imageService.handelImage(file, "avatar");
        }
        user.setImage(imageName);
        User savedUser = this.userRepository.save(user);

        // Thêm voucher “welcome” cho user mới
        var welcomeVoucher = this.voucherRepository.findByCode("WELCOME10");
        if (welcomeVoucher != null) {
            UserVoucher userVoucher = new UserVoucher();
            userVoucher.setUser(savedUser);
            userVoucher.setVoucher(welcomeVoucher);
            userVoucher.setQuantity(1);
            this.userVoucherRepo.save(userVoucher);
        }
    }
    @Transactional
    public void assignVouchersToUser(Integer userId, List<Integer> voucherIds) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
         // Nếu voucherIds == null, gán list rỗng 
        if (voucherIds == null) {
            voucherIds = List.of(); 
        }
        List<UserVoucher> existingUserVouchers = userVoucherRepo.findByUser(user);

        // Xóa voucher không còn được chọn
        for (UserVoucher uv : existingUserVouchers) {
            if (!voucherIds.contains(uv.getVoucher().getId())) {
                userVoucherRepo.delete(uv);
            }
        }

        // Thêm voucher mới được chọn
        for (Integer voucherId : voucherIds) {
            Voucher voucher = voucherRepository.findById(voucherId)
                    .orElseThrow(() -> new RuntimeException("Voucher not found"));

            boolean exists = userVoucherRepo.existsByUserAndVoucher(user, voucher);
            if (!exists) {
                UserVoucher newUserVoucher = new UserVoucher();
                newUserVoucher.setUser(user);
                newUserVoucher.setVoucher(voucher);
                newUserVoucher.setQuantity(1);
                userVoucherRepo.save(newUserVoucher);
            }
        }
    }

    public User updateUser(User user, MultipartFile file) {
        User currentUser = this.userRepository.findById(user.getId()).get();

        currentUser.setRole(this.roleRepository.findByName(user.getRole().getName()));

        if (user.getPhoneNumber() != null && !user.getPhoneNumber().isEmpty()) {
            currentUser.setPhoneNumber(user.getPhoneNumber());
        }
        if (user.getFullName() != null && !user.getFullName().isEmpty()) {
            currentUser.setFullName(user.getFullName());
        }
        if (user.getAddress() != null && !user.getAddress().isEmpty()) {
            currentUser.setAddress(user.getAddress());
        }
        if (user.getUsername() != null && !user.getUsername().isEmpty()) {
            currentUser.setUsername(user.getUsername());
        }
        // Kiểm tra xem người dùng có cập nhật ảnh không nếu có thì cập nhật
        String updateImage = this.imageService.handelImage(file, "avatar");
        if (updateImage != null && !updateImage.isEmpty()) {
            // Kiểm tra xem người dùng hiện tại có ảnh và KHÔNG phải ảnh mặc định thì mới
            // xóa
            if (currentUser.getImage() != null
                    && !currentUser.getImage().isEmpty()
                    && !currentUser.getImage().equals("defaultavatar.jpg")) {
                this.imageService.deleteImage(currentUser.getImage(), "avatar");
            }
            currentUser.setImage(updateImage);
        }
        return this.userRepository.save(currentUser);
    }

    public List<User> getUserList() {
        return this.userRepository.findAll();
    }

    public void deleteUser(User user) {
        if (user.getImage() != null && !user.getImage().equals("defaultavatar.jpg")) {
            imageService.deleteImage(user.getImage(), "avatar");
        }
        this.userRepository.deleteById(user.getId());
    }

    public User getUserByID(int id) {
        return this.userRepository.findFirstById(id);
    }

    public User getUserByUsername(String username) {
        return this.userRepository.findByUsername(username);
    }

    public boolean checkEmailExist(String email) {
        return this.userRepository.existsByEmail(email);
    }

    public boolean checkUsernameExist(String username) {
        return this.userRepository.existsByUsername(username);
    }

    public Page<User> fetchUsers(Pageable pageable) {
        return this.userRepository.findAll(pageable);
    }
    public List<User> getActiveUsers() {
        return userRepository.findByStatus(1);
    }

    public void softDeleteUser(Integer id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));
        
        if(user.getStatus()==1){
            user.setStatus(0);
        }
        else{
            user.setStatus(1);
        }
    
        userRepository.save(user);
    }

    public List<UserVoucher> getActiveVoucherListMoreThan(User user, int quantity) {
        return this.userVoucherRepo.findByUserAndStatusAndQuantityGreaterThan(user.getId(), 1, quantity);
    }

    public Voucher getVoucherByCodeAndUser (String code, User user) {
        Voucher voucher = this.voucherRepository.findByCode(code);
        UserVoucher userVoucher = this.userVoucherRepo.findByUserAndVoucher(user, voucher);
        return userVoucher.getVoucher();
    }
    public long countActiveUsers() {
        return userRepository.countByStatus(1);
    }
}
