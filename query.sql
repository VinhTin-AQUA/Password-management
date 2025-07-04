CREATE TABLE Accounts (
    Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    AppName TEXT NOT NULL,
    UserName TEXT NOT NULL,
    Password TEXT NOT NULL,
    Note TEXT,
    UserId TEXT NOT NULL
);

CREATE TABLE Passcodes (
    Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    Passcode TEXT NOT NULL,
    UserId TEXT NOT NULL
);

--------------------------------------------------------
--------------------- accounts ------------------------
--------------------------------------------------------

-- Cho phép SELECT: Người dùng chỉ xem được các bản ghi của chính họ
CREATE POLICY "Allow users to read their own accounts" 
ON accounts FOR SELECT 
TO authenticated 
USING (auth.uid() = user_id);

-- Cho phép INSERT: Người dùng có thể thêm bản ghi mới với user_id là id của họ
CREATE POLICY "Allow users to insert their own accounts" 
ON accounts FOR INSERT 
TO authenticated 
WITH CHECK (auth.uid() = user_id);

-- Cho phép UPDATE: Người dùng chỉ cập nhật các bản ghi của chính họ
CREATE POLICY "Allow users to update their own accounts" 
ON accounts FOR UPDATE 
TO authenticated 
USING (auth.uid() = user_id) 
WITH CHECK (auth.uid() = user_id);

-- Cho phép DELETE: Người dùng chỉ xóa các bản ghi của chính họ
CREATE POLICY "Allow users to delete their own accounts" 
ON accounts FOR DELETE 
TO authenticated 
USING (auth.uid() = user_id);

--------------------------------------------------------
--------------------- passcodes ------------------------
--------------------------------------------------------

-- Cho phép SELECT: Người dùng chỉ xem được các bản ghi của chính họ
CREATE POLICY "Allow users to read their own passcodes" 
ON passcodes FOR SELECT 
TO authenticated 
USING (auth.uid() = user_id);

-- Cho phép INSERT: Người dùng có thể thêm bản ghi mới với user_id là id của họ
CREATE POLICY "Allow users to insert their own passcodes" 
ON passcodes FOR INSERT 
TO authenticated 
WITH CHECK (auth.uid() = user_id);

-- Cho phép UPDATE: Người dùng chỉ cập nhật các bản ghi của chính họ
CREATE POLICY "Allow users to update their own passcodes" 
ON passcodes FOR UPDATE 
TO authenticated 
USING (auth.uid() = user_id) 
WITH CHECK (auth.uid() = user_id);

-- Cho phép DELETE: Người dùng chỉ xóa các bản ghi của chính họ
CREATE POLICY "Allow users to delete their own passcodes" 
ON passcodes FOR DELETE 
TO authenticated 
USING (auth.uid() = user_id);