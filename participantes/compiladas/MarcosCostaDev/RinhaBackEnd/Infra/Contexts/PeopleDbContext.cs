using RinhaBackEnd.Domain;
using System.Diagnostics.CodeAnalysis;

namespace RinhaBackEnd.Infra.Contexts;

public class PeopleDbContext : DbContext
{
    public DbSet<Person> People { get; set; }
    public DbSet<Stack> Stacks { get; set; }
    public DbSet<PersonStack> PersonStacks { get; set; }

    public PeopleDbContext([NotNull] DbContextOptions<PeopleDbContext> options) : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        builder.Entity<Person>(entity =>
        {
            entity.ToTable("People");
            entity.HasKey(p => p.Id);
        });

        builder.Entity<Stack>(entity =>
        {
            entity.ToTable("Stacks");
            entity.HasKey(p => p.Id);
        });

        builder.Entity<PersonStack>(entity =>
        {
            entity.ToTable("PersonStacks");

            entity.HasKey(p => new { p.StackId, p.PersonId });

            entity.HasOne(p => p.Person)
                  .WithMany(p => p.PersonStacks)
                  .HasForeignKey(p => p.PersonId)
                  .OnDelete(DeleteBehavior.Cascade);

            entity.HasOne(p => p.Stack)
                  .WithMany(p => p.PersonStacks)
                  .HasForeignKey(p => p.StackId)
                  .OnDelete(DeleteBehavior.Cascade);
        });

        builder.Ignore<Notification>()
               .Ignore<Notifiable<Notification>>();
    }
}
