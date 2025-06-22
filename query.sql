CREATE TABLE Accounts (
    Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    AppName TEXT NOT NULL,
    UserName TEXT NOT NULL,
    Password TEXT NOT NULL,
    Note TEXT,
    UserId TEXT NOT NULL
);
