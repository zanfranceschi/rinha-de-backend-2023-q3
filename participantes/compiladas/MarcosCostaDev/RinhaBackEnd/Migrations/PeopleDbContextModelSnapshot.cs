﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Npgsql.EntityFrameworkCore.PostgreSQL.Metadata;
using RinhaBackEnd.Infra.Contexts;

#nullable disable

namespace RinhaBackEnd.Migrations
{
    [DbContext(typeof(PeopleDbContext))]
    partial class PeopleDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.9")
                .HasAnnotation("Relational:MaxIdentifierLength", 63);

            NpgsqlModelBuilderExtensions.UseIdentityByDefaultColumns(modelBuilder);

            modelBuilder.Entity("RinhaBackEnd.Domain.Person", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Apelido")
                        .IsRequired()
                        .HasColumnType("text");

                    b.Property<DateTime>("Nascimento")
                        .HasColumnType("timestamp with time zone");

                    b.Property<string>("Nome")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("People", (string)null);
                });

            modelBuilder.Entity("RinhaBackEnd.Domain.PersonStack", b =>
                {
                    b.Property<Guid>("StackId")
                        .HasColumnType("uuid");

                    b.Property<Guid>("PersonId")
                        .HasColumnType("uuid");

                    b.HasKey("StackId", "PersonId");

                    b.HasIndex("PersonId");

                    b.ToTable("PersonStacks", (string)null);
                });

            modelBuilder.Entity("RinhaBackEnd.Domain.Stack", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("uuid");

                    b.Property<string>("Nome")
                        .IsRequired()
                        .HasColumnType("text");

                    b.HasKey("Id");

                    b.ToTable("Stacks", (string)null);
                });

            modelBuilder.Entity("RinhaBackEnd.Domain.PersonStack", b =>
                {
                    b.HasOne("RinhaBackEnd.Domain.Person", "Person")
                        .WithMany("PersonStacks")
                        .HasForeignKey("PersonId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("RinhaBackEnd.Domain.Stack", "Stack")
                        .WithMany("PersonStacks")
                        .HasForeignKey("StackId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Person");

                    b.Navigation("Stack");
                });

            modelBuilder.Entity("RinhaBackEnd.Domain.Person", b =>
                {
                    b.Navigation("PersonStacks");
                });

            modelBuilder.Entity("RinhaBackEnd.Domain.Stack", b =>
                {
                    b.Navigation("PersonStacks");
                });
#pragma warning restore 612, 618
        }
    }
}
