defmodule Discuss.Repo.Migrations.AddUserIdToTopics do
  use Ecto.Migration

  # This does not create a table, it makes a change to an existing one, hence alter
  # THis connects to the two tables together. I also told Phoenix it as well
  def change do
    alter table(:topics) do
      add :user_id, references(:users) #This tells us that we are using the user_id and we are referencing the users table
    end
  end
end
