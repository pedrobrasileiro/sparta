class AddFunctionFindInSet < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.connection.execute <<-EOF
      create or replace function find_in_set(str text, strlist text)
      returns int as $$
      select i
        from generate_subscripts(string_to_array($2,','),1) g(i)
        where (string_to_array($2,','))[i] = $1
        union all
        select 0
        limit 1
      $$ language sql strict;
    EOF
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
