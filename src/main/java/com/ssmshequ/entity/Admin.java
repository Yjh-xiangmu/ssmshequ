package com.ssmshequ.entity;

public class Admin {
    private Integer id;
    private String username;
    private String password;
    private String name;
    private String phone;

    // Getter 和 Setter 方法 (手写或使用快捷键生成)
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
}