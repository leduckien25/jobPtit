
CREATE DATABASE JobPtit;
GO;
USE JobPtit;
GO;
-- ==============================
-- 1. Users
-- ==============================
CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(500) NOT NULL,
    Role INT NOT NULL, -- 1=Candidate, 2=Recruiter, 3=Admin
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    IsActive BIT NOT NULL DEFAULT 1
);

-- ==============================
-- 2. CandidateProfiles
-- ==============================
CREATE TABLE CandidateProfiles (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL UNIQUE,
    FullName NVARCHAR(255) NOT NULL,
    Title NVARCHAR(255),
    Phone NVARCHAR(50),
    Location NVARCHAR(255),
    AboutMe NVARCHAR(MAX),
    AvatarUrl NVARCHAR(500),
    CVUrl NVARCHAR(500),

    CONSTRAINT FK_CandidateProfiles_Users
        FOREIGN KEY (UserId) REFERENCES Users(Id)
        ON DELETE CASCADE
);

-- ==============================
-- 3. Skills
-- ==============================
CREATE TABLE Skills (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(150) NOT NULL UNIQUE
);

-- ==============================
-- 4. CandidateSkills (Many-to-Many)
-- ==============================
CREATE TABLE CandidateSkills (
    CandidateProfileId INT NOT NULL,
    SkillId INT NOT NULL,

    PRIMARY KEY (CandidateProfileId, SkillId),

    CONSTRAINT FK_CandidateSkills_Profile
        FOREIGN KEY (CandidateProfileId)
        REFERENCES CandidateProfiles(Id)
        ON DELETE CASCADE,

    CONSTRAINT FK_CandidateSkills_Skill
        FOREIGN KEY (SkillId)
        REFERENCES Skills(Id)
        ON DELETE CASCADE
);

-- ==============================
-- 5. WorkExperiences
-- ==============================
CREATE TABLE WorkExperiences (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CandidateProfileId INT NOT NULL,
    CompanyName NVARCHAR(255) NOT NULL,
    Position NVARCHAR(255) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL,
    Description NVARCHAR(MAX),

    CONSTRAINT FK_WorkExperiences_Profile
        FOREIGN KEY (CandidateProfileId)
        REFERENCES CandidateProfiles(Id)
        ON DELETE CASCADE
);

-- ==============================
-- 6. Educations
-- ==============================
CREATE TABLE Educations (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CandidateProfileId INT NOT NULL,
    SchoolName NVARCHAR(255) NOT NULL,
    Degree NVARCHAR(255),
    StartDate DATE NOT NULL,
    EndDate DATE NULL,

    CONSTRAINT FK_Educations_Profile
        FOREIGN KEY (CandidateProfileId)
        REFERENCES CandidateProfiles(Id)
        ON DELETE CASCADE
);

-- ==============================
-- 7. Companies
-- ==============================
CREATE TABLE Companies (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Location NVARCHAR(255),
    LogoUrl NVARCHAR(500),
    Description NVARCHAR(MAX),
    OwnerUserId INT NOT NULL,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    IsVerified BIT NOT NULL DEFAULT 0,

    CONSTRAINT FK_Companies_Users
        FOREIGN KEY (OwnerUserId)
        REFERENCES Users(Id)
);

-- ==============================
-- 8. Categories
-- ==============================
CREATE TABLE Categories (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Slug NVARCHAR(255) NOT NULL UNIQUE,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE()
);

-- ==============================
-- 9. Jobs
-- ==============================
CREATE TABLE Jobs (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    Location NVARCHAR(255),

    SalaryMin INT NULL,
    SalaryMax INT NULL,
    IsNegotiable BIT NOT NULL DEFAULT 0,

    JobType INT NOT NULL, -- 1=FullTime,2=PartTime,3=Internship
    Status INT NOT NULL,  -- 0=Pending,1=Active,2=Expired,3=Rejected

    CategoryId INT NOT NULL,
    CompanyId INT NOT NULL,
    CreatedByUserId INT NOT NULL,

    ViewsCount INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETDATE(),
    ExpiredAt DATETIME2 NULL,

    CONSTRAINT FK_Jobs_Category
        FOREIGN KEY (CategoryId)
        REFERENCES Categories(Id),

    CONSTRAINT FK_Jobs_Company
        FOREIGN KEY (CompanyId)
        REFERENCES Companies(Id),

    CONSTRAINT FK_Jobs_User
        FOREIGN KEY (CreatedByUserId)
        REFERENCES Users(Id)
);

-- ==============================
-- 10. Applications
-- ==============================
CREATE TABLE Applications (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    JobId INT NOT NULL,
    Status INT NOT NULL, -- 0=Pending,1=Reviewed,2=Interviewing,3=Rejected,4=Accepted
    AppliedAt DATETIME2 NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Applications_User
        FOREIGN KEY (UserId)
        REFERENCES Users(Id),

    CONSTRAINT FK_Applications_Job
        FOREIGN KEY (JobId)
        REFERENCES Jobs(Id)
        ON DELETE CASCADE,

    CONSTRAINT UQ_User_Job UNIQUE (UserId, JobId)
);
