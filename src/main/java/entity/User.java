package entity;

import java.io.Serializable;
import java.sql.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="[User]")
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String email;
    private String username;
    
    // BẮT BUỘC PHẢI LÀ NVARCHAR ĐỂ LƯU TIẾNG VIỆT
    @Column(name="fullname", columnDefinition = "NVARCHAR(100)")
    private String fullname;

    private String password;
    private String avatar;
    private int roleid;
    private String phone;
    
    @Column(name="createddate")
    private Date createdDate;

    public User() {}

    // --- CÁC HÀM GETTER & SETTER GIỮ NGUYÊN BÊN DƯỚI ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getUserName() { return username; }
    public void setUserName(String username) { this.username = username; }
    public String getFullName() { return fullname; }
    public void setFullName(String fullname) { this.fullname = fullname; }
    public String getPassWord() { return password; }
    public void setPassWord(String password) { this.password = password; }
    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }
    public int getRoleid() { return roleid; }
    public void setRoleid(int roleid) { this.roleid = roleid; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public Date getCreatedDate() { return createdDate; }
    public void setCreatedDate(Date createdDate) { this.createdDate = createdDate; }
}