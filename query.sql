CREATE TABLE Accounts (
    Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    AppName TEXT NOT NULL,
    UserName TEXT NOT NULL,
    Password TEXT NOT NULL,
    Note TEXT,
    UserId TEXT NOT NULL
);

--------------------------------------------------------
--------------------- accounts ------------------------
--------------------------------------------------------

-- SELECT
CREATE POLICY "Allow anyone to select accounts"
ON accounts FOR SELECT
TO public
USING (true);

-- INSERT
CREATE POLICY "Allow anyone to insert accounts"
ON accounts FOR INSERT
TO public
WITH CHECK (true);

-- UPDATE
CREATE POLICY "Allow anyone to update accounts"
ON accounts FOR UPDATE
TO public
USING (true)
WITH CHECK (true);

-- DELETE
CREATE POLICY "Allow anyone to delete accounts"
ON accounts FOR DELETE
TO public
USING (true);

---- batch update accounts
create or replace function batch_update_accounts(data jsonb)
returns void as $$
declare
  item jsonb;
begin
  for item in select * from jsonb_array_elements(data)
  loop
    update accounts
    set
      appname = item->>'appname',
      username = item->>'username',
      password = item->>'password',
      note = item->>'note'
    where id = (item->>'id')::uuid; -- int or uuid
  end loop;
end;
$$ language plpgsql;
