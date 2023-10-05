using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Restaurant.Models.RestaurantModels;
using Restaurant.Models.Users;
using Restaurant.Models.Identity;
using Microsoft.AspNetCore.Identity;

namespace Restaurant.Data;

public class RestaurantContext : IdentityDbContext<User, Role, Guid, UserClaim, UserRole, UserLogin, RoleClaim, UserToken>
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

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<UserRole> UserRoles { get; set; }

    public virtual DbSet<RoleClaim> RoleClaims { get; set; }

    public virtual DbSet<UserClaim> UserClaims { get; set; }
    public virtual DbSet<UserLogin> UserLogins { get; set; }
    public virtual DbSet<UserToken> UserTokens { get; set; }

    public virtual DbSet<User> Users { get; set; }


    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);


        modelBuilder.Entity<User>(b =>
        {
            b.HasKey("Id");
            b.ToTable("users");
            // Each User can have many UserClaims
            b.HasMany(e => e.Claims)
                .WithOne(e => e.User)
                .HasForeignKey(uc => uc.UserId)
                .IsRequired();

            // Each User can have many UserLogins
            b.HasMany(e => e.Logins)
                .WithOne(e => e.User)
                .HasForeignKey(ul => ul.UserId)
                .IsRequired();

            // Each User can have many UserTokens
            b.HasMany(e => e.Tokens)
                .WithOne(e => e.User)
                .HasForeignKey(ut => ut.UserId)
                .IsRequired();

            // Each User can have many entries in the UserRole join table
            b.HasMany(e => e.UserRoles)
                .WithOne(e => e.User)
                .HasForeignKey(ur => ur.UserId)
                .IsRequired();
        });


        modelBuilder.Entity<Role>(b =>
        {
            b.HasKey("Id");
            b. ToTable("roles");
            // Each Role can have many entries in the UserRole join table
            b.HasMany(e => e.UserRoles)
                .WithOne(e => e.Roles)
                .HasForeignKey(ur => ur.RoleId)
                .IsRequired();

            // Each Role can have many associated RoleClaims
            b.HasMany(e => e.RoleClaims)
                .WithOne(e => e.Roles)
                .HasForeignKey(rc => rc.RoleId)
                .IsRequired();
        });

        modelBuilder.Entity<UserRole>().ToTable("UserRoles").HasKey(x => new { x.UserId, x.RoleId });
        modelBuilder.Entity<RoleClaim>().ToTable("RoleClaims");
        modelBuilder.Entity<UserClaim>().ToTable("UserClaims");
        modelBuilder.Entity<UserLogin>().ToTable("UserLogins").HasKey(x => new { x.LoginProvider, x.ProviderKey });
        modelBuilder.Entity<UserToken>().ToTable("UserTokens").HasKey(x => new { x.UserId, x.LoginProvider, x.Name });
        //SeedRoles(modelBuilder);

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
            entity.Property(e => e.CustomerId)
                .HasColumnName("customer_id")
                .UseCollation("ascii_general_ci")
                .HasCharSet("ascii");
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
            entity.Property(e => e.CustomerId)
                .HasColumnName("customer_id")
                .UseCollation("ascii_general_ci")
                .HasCharSet("ascii");
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
            entity.Property(e => e.TotalPrice).HasColumnName("totalPrice");

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
            entity.Property(e => e.MeanId).HasColumnName("mean_id");
            entity.Property(e => e.MenuItemId).HasColumnName("menuItem_id");
            entity.Property(e => e.Quantity).HasColumnName("quantity");
            entity.Property(e => e.TotalPrice).HasColumnName("totalPrice");

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
            entity.Property(e => e.CashierId)
                .HasColumnName("cashier_id")
                .UseCollation("ascii_general_ci")
                .HasCharSet("ascii");
            entity.Property(e => e.OrderTime)
                .HasColumnType("timestamp")
                .HasColumnName("order_time");
            entity.Property(e => e.Status)
                .HasColumnType("enum('Chưa thanh toán','Đã thanh toán','Đã hủy')")
                .HasColumnName("status");
            entity.Property(e => e.TableId).HasColumnName("table_id");
            entity.Property(e => e.TotalPrice).HasColumnName("totalPrice");

            entity.HasOne(d => d.Cashier).WithMany(p => p.Orders)
                .HasForeignKey(d => d.CashierId)
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

            entity.HasIndex(e => e.IdWaiter, "fk_idwaiterx");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.IdWaiter)
                .HasColumnName("id_waiter")
                .UseCollation("ascii_general_ci")
                .HasCharSet("ascii");
            entity.Property(e => e.RestaurantId).HasColumnName("restaurant_id");
            entity.Property(e => e.Seats).HasColumnName("seats");
            entity.Property(e => e.Status)
                .HasColumnType("enum('Chưa đặt','Đang đặt')")
                .HasColumnName("status");
            entity.Property(e => e.TableNumber).HasColumnName("table_number");

            entity.HasOne(d => d.Restaurant).WithMany(p => p.Tables)
                .HasForeignKey(d => d.RestaurantId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("fk_restaurant");
        });

        
    }
}
