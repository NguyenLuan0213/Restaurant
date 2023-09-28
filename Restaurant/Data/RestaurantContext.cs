using System;
using System.Collections.Generic;
using System.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Restaurant.Models;
using Restaurant.Models.RestaurantModels;
using Restaurant.Models.Users;

namespace Restaurant.Data;

public partial class RestaurantContext : IdentityDbContext<IdentityUser>
{
    public RestaurantContext(DbContextOptions<RestaurantContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Bill> Bills { get; set; }

    public virtual DbSet<Comment> Comments { get; set; }

    public virtual DbSet<Mean> Means { get; set; }

    public virtual DbSet<Meanitem> Meanitems { get; set; }

    public virtual DbSet<Menu> Menus { get; set; }

    public virtual DbSet<Menuitem> Menuitems { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<Promotion> Promotions { get; set; }

    public virtual DbSet<Restaurantsbr> Restaurantsbrs { get; set; }

    public virtual DbSet<Table> Tables { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        SeedRoles(modelBuilder);

        modelBuilder
            .UseCollation("utf8mb4_0900_ai_ci")
            .HasCharSet("utf8mb4");

        modelBuilder.Entity<Bill>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity
                .ToTable("bill")
                .UseCollation("utf8mb4_unicode_ci");

            entity.HasIndex(e => e.CustomerId, "fk_bill_customer_idx");

            entity.HasIndex(e => e.OrderId, "fk_bill_order_idx");

            entity.HasIndex(e => e.PromotionId, "fk_bill_promotion_idx");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.BillDate)
                .HasColumnType("timestamp")
                .HasColumnName("bill_date");
            entity.Property(e => e.CustomerId).HasColumnName("customer_id");
            entity.Property(e => e.DiscountAmount)
                .HasPrecision(10, 2)
                .HasColumnName("discount_amount");
            entity.Property(e => e.OrderId).HasColumnName("order_id");
            entity.Property(e => e.PromotionId).HasColumnName("promotion_id");
            entity.Property(e => e.TotalAmount)
                .HasPrecision(10, 2)
                .HasColumnName("total_amount");

            entity.HasOne(d => d.Customer).WithMany(p => p.Bills)
                .HasForeignKey(d => d.CustomerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_bill_customer");

            entity.HasOne(d => d.Order).WithMany(p => p.Bills)
                .HasForeignKey(d => d.OrderId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_bill_order");

            entity.HasOne(d => d.Promotion).WithMany(p => p.Bills)
                .HasForeignKey(d => d.PromotionId)
                .HasConstraintName("fk_bill_promotion");
        });

        modelBuilder.Entity<Comment>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity
                .ToTable("comment")
                .UseCollation("utf8mb4_unicode_ci");

            entity.HasIndex(e => e.CustomerId, "fk_coment_customer_idx");

            entity.HasIndex(e => e.RestaurantId, "fk_coment_restaurant_idx");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.CommentDate).HasColumnName("comment_date");
            entity.Property(e => e.CustomerId).HasColumnName("customer_id");
            entity.Property(e => e.Rating).HasColumnName("rating");
            entity.Property(e => e.RestaurantId).HasColumnName("restaurant_id");
            entity.Property(e => e.ReviewText)
                .HasColumnType("text")
                .HasColumnName("review_text");

            entity.HasOne(d => d.Customer).WithMany(p => p.Comments)
                .HasForeignKey(d => d.CustomerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_coment_customer");

            entity.HasOne(d => d.Restaurant).WithMany(p => p.Comments)
                .HasForeignKey(d => d.RestaurantId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_coment_restaurant");
        });

        modelBuilder.Entity<Mean>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("mean");

            entity.HasIndex(e => e.OrderId, "fk_mean_order_idx");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Description)
                .HasColumnType("text")
                .HasColumnName("description");
            entity.Property(e => e.OrderId).HasColumnName("order_id");

            entity.HasOne(d => d.Order).WithMany(p => p.Means)
                .HasForeignKey(d => d.OrderId)
                .HasConstraintName("fk_mean_order");
        });

        modelBuilder.Entity<Meanitem>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("meanitem");

            entity.HasIndex(e => e.MeanId, "fk_meanItem_mean_idx");

            entity.HasIndex(e => e.MenuItemId, "fk_meanItem_menuItem_idx");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.TotalPrice).HasColumnName("totalPrice");
            entity.Property(e => e.MeanId).HasColumnName("mean_id");
            entity.Property(e => e.MenuItemId).HasColumnName("menuItem_id");
            entity.Property(e => e.Quantity).HasColumnName("quantity");

            entity.HasOne(d => d.Mean).WithMany(p => p.Meanitems)
                .HasForeignKey(d => d.MeanId)
                .HasConstraintName("fk_meanItem_mean");

            entity.HasOne(d => d.MenuItem).WithMany(p => p.Meanitems)
                .HasForeignKey(d => d.MenuItemId)
                .HasConstraintName("fk_meanItem_menuItem");
        });

        modelBuilder.Entity<Menu>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity
                .ToTable("menu")
                .UseCollation("utf8mb4_unicode_ci");

            entity.HasIndex(e => e.RestaurantId, "fk_menu_restaurant_idx");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Description)
                .HasColumnType("text")
                .HasColumnName("description");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
            entity.Property(e => e.RestaurantId).HasColumnName("restaurant_id");

            entity.HasOne(d => d.Restaurant).WithMany(p => p.Menus)
                .HasForeignKey(d => d.RestaurantId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_menu_restaurant");
        });

        modelBuilder.Entity<Menuitem>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity
                .ToTable("menuitem")
                .UseCollation("utf8mb4_unicode_ci");

            entity.HasIndex(e => e.MenuId, "fk_menu_menus_idx");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Description)
                .HasColumnType("text")
                .HasColumnName("description");
            entity.Property(e => e.Image)
                .HasMaxLength(255)
                .HasColumnName("image");
            entity.Property(e => e.MenuId).HasColumnName("menu_id");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
            entity.Property(e => e.Price)
                .HasPrecision(10, 2)
                .HasColumnName("price");

            entity.HasOne(d => d.Menu).WithMany(p => p.Menuitems)
                .HasForeignKey(d => d.MenuId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_menu_menus");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity
                .ToTable("orders")
                .UseCollation("utf8mb4_unicode_ci");

            entity.HasIndex(e => e.CashierId, "fk_order_cashier_idx");

            entity.HasIndex(e => e.TableId, "fk_order_tables_idx");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.CashierId).HasColumnName("cashier_id");
            entity.Property(e => e.OrderTime)
                .HasColumnType("timestamp")
                .HasColumnName("order_time");
            entity.Property(e => e.Status)
                .HasColumnType("enum('Chưa thanh toán','Đã thanh toán','Đã hủy')")
                .HasColumnName("status");
            entity.Property(e => e.TableId).HasColumnName("table_id");

            entity.HasOne(d => d.Cashier).WithMany(p => p.Orders)
                .HasForeignKey(d => d.CashierId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_order_cashier");

            entity.HasOne(d => d.Table).WithMany(p => p.Orders)
                .HasForeignKey(d => d.TableId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_order_tables");
        });

        modelBuilder.Entity<Promotion>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity
                .ToTable("promotion")
                .UseCollation("utf8mb4_unicode_ci");

            entity.HasIndex(e => e.RestaurantId, "fk_promotion_restaurant_idx");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Description)
                .HasColumnType("text")
                .HasColumnName("description");
            entity.Property(e => e.Discount)
                .HasPrecision(5, 2)
                .HasColumnName("discount");
            entity.Property(e => e.EndDate)
                .HasColumnType("timestamp")
                .HasColumnName("end_date");
            entity.Property(e => e.PromotionName)
                .HasMaxLength(100)
                .HasColumnName("promotion_name");
            entity.Property(e => e.RestaurantId).HasColumnName("restaurant_id");
            entity.Property(e => e.StartDate)
                .HasColumnType("timestamp")
                .HasColumnName("start_date");

            entity.HasOne(d => d.Restaurant).WithMany(p => p.Promotions)
                .HasForeignKey(d => d.RestaurantId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_promotion_restaurant");
        });

        modelBuilder.Entity<Restaurantsbr>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity
                .ToTable("restaurantsbr")
                .UseCollation("utf8mb4_unicode_ci");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Address)
                .HasColumnType("text")
                .HasColumnName("address");
            entity.Property(e => e.Description)
                .HasColumnType("text")
                .HasColumnName("description");
            entity.Property(e => e.Name)
                .HasMaxLength(100)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Table>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity
                .ToTable("tables")
                .UseCollation("utf8mb4_unicode_ci");

            entity.HasIndex(e => e.RestaurantId, "fk_restaurant_idx");

            entity.HasIndex(e => e.IdWaiter, "fk_restaurant_waiter_idx");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.IdWaiter).HasColumnName("id_waiter");
            entity.Property(e => e.RestaurantId).HasColumnName("restaurant_id");
            entity.Property(e => e.Seats).HasColumnName("seats");
            entity.Property(e => e.Status)
                .HasColumnType("enum('Chưa đặt','Đang đặt')")
                .HasColumnName("status");
            entity.Property(e => e.TableNumber).HasColumnName("table_number");

            entity.HasOne(d => d.IdWaiterNavigation).WithMany(p => p.Tables)
                .HasForeignKey(d => d.IdWaiter)
                .HasConstraintName("fk_restaurant_waiter");

            entity.HasOne(d => d.Restaurant).WithMany(p => p.Tables)
                .HasForeignKey(d => d.RestaurantId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_restaurant");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity
                .ToTable("users")
                .UseCollation("utf8mb4_unicode_ci");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Address)
                .HasColumnType("text")
                .HasColumnName("address");
            entity.Property(e => e.Email)
                .HasMaxLength(100)
                .HasColumnName("email");
            entity.Property(e => e.Fullname)
                .HasMaxLength(50)
                .HasColumnName("fullname");
            entity.Property(e => e.Image)
                .HasMaxLength(255)
                .HasColumnName("image");
            entity.Property(e => e.Password)
                .HasMaxLength(100)
                .HasColumnName("password");
            entity.Property(e => e.Phone)
                .HasMaxLength(20)
                .HasColumnName("phone");
            entity.Property(e => e.Roles)
                .HasColumnType("enum('ADMIN','CUSTOMER','WAITER','CASHIER')")
                .HasColumnName("roles");
            entity.Property(e => e.UserName)
                .HasMaxLength(50)
                .HasColumnName("username");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    private static void SeedRoles(ModelBuilder builder)
    {
        builder.Entity<IdentityRole>().HasData
            (
            new IdentityRole() { Name = "ADMIN", ConcurrencyStamp = "1", NormalizedName = "ADMIN" },
            new IdentityRole() { Name = "CUSTORMER", ConcurrencyStamp = "2", NormalizedName = "CUSTORMER" },
            new IdentityRole() { Name = "CASHIER", ConcurrencyStamp = "3", NormalizedName = "CASHIER" },
            new IdentityRole() { Name = "WAITER", ConcurrencyStamp = "4", NormalizedName = "WAITER" }
            );
    }
    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
