/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ApplicationDetail {
    private int appId;
    private CandidateProfile profile; // Model bạn đã có
    private String email;
    private int status;
    private LocalDateTime appliedAt;

    public ApplicationDetail() {}

    // Getters and Setters
    public int getAppId() { return appId; }
    public void setAppId(int appId) { this.appId = appId; }
    public CandidateProfile getProfile() { return profile; }
    public void setProfile(CandidateProfile profile) { this.profile = profile; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
    public LocalDateTime getAppliedAt() { return appliedAt; }
    public void setAppliedAt(LocalDateTime appliedAt) { this.appliedAt = appliedAt; }
    public String getAppliedAtFormatted() {
        if (appliedAt != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            return appliedAt.format(formatter);
        }
        return "";
    }
}