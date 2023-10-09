using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Restaurant.Converters;
using Restaurant.Data;
using Restaurant.Models.Users;
using Restaurant.Repository;
using Restaurant.Repository.Interfaces;
using Restaurant.Service;
using Restaurant.Service.Interface;
using Restaurant.Threading;
using Stripe;
using System.Text;
using Role = Restaurant.Models.Identity.Role;

namespace Restaurant
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddControllers();
            services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());
            services.AddScoped<IRestaurantsbrRepository, RestaurantsbrRepository>();
            services.AddScoped<ITablesRepository, TablesRepository>();
            services.AddScoped<IMenuRepository, MenuRepository>();
            services.AddScoped<IPromotionsRepository, PromotionsRepository>();
            services.AddScoped<IBillRepository, BillRepository>();
            services.AddScoped<IMenuItemRepository, MenuItemRepository>();
            services.AddScoped<IOrdersRepository, OrdersRepository>();
            services.AddScoped<ICommentRepository, CommentRepository>();
            services.AddScoped<IMeanRepository, MeanRepository>();
            services.AddScoped<IMeanItemRepository, MeanItemRepository>();
            //services.AddScoped<IOrderService, OrderService>();

            //services.AddScoped<IUsersRepository, UsersRepository>();
            services.AddSingleton<ISystemClock, SystemClock>();
            services.AddIdentity<User, Role>()
                .AddEntityFrameworkStores<RestaurantContext>()
                .AddDefaultTokenProviders();

            //JWT

            //services.Configure<IdentityOptions>(options =>
            //{
            //    // Password settings
            //    options.Password.RequireDigit = true;
            //    options.Password.RequiredLength = 10;
            //    options.Password.RequireNonAlphanumeric = true;
            //    options.Password.RequireUppercase = false;
            //    options.Password.RequireLowercase = false;
            //    options.Password.RequiredUniqueChars = 6;

            //    // Lockout settings
            //    options.Lockout.DefaultLockoutTimeSpan = TimeSpan.FromDays(1);
            //    options.Lockout.MaxFailedAccessAttempts = 10;
            //    options.Lockout.AllowedForNewUsers = true;

            //    // User settings
            //    options.User.RequireUniqueEmail = true;
            //});

            services.AddCors(options =>
            {
                options.AddPolicy("AllowAll", builder =>
                {
                    builder
                    .WithOrigins(new[] { "http://localhost:3000", "https://localhost:7274" })
                    .AllowAnyOrigin()
                    .AllowAnyMethod()
                    .AllowAnyHeader();
                });
            });
            services.AddAuthentication(options =>
            {
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
            }).AddJwtBearer(options =>
            {
                options.SaveToken = true;
                options.RequireHttpsMetadata = false;
                options.TokenValidationParameters = new TokenValidationParameters()
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidAudience = Configuration["JWT:ValidAudience"],
                    ValidIssuer = Configuration["JWT:ValidIssuer"],
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration["JWT:Secret"]))
                };
            });

            //var emailConfig = Configuration.GetSection("EmailConfiguration").Get<EmailConfiguration>();
            //services.AddSingleton(emailConfig);

            //services.AddScoped<IEmailService, EmailService>();
            //----------------------------------------------------------------------------//

            services.AddControllers().AddJsonOptions(options =>
            {
                options.JsonSerializerOptions.Converters.Add(new FormatDateTime());
                options.JsonSerializerOptions.Converters.Add(new FormatDate());
            });

            services.AddDbContext<RestaurantContext>(
                options =>
                {
                    options.UseMySql(Configuration.GetConnectionString("RestaurantDB"),
                        Microsoft.EntityFrameworkCore.ServerVersion.Parse("8.0.31-mysql"));
                });

            services.AddSwaggerGen(option =>
            {
                option.SwaggerDoc("v1", new OpenApiInfo { Title = "Restaurant API", Version = "v1" });
                option.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
                {
                    In = ParameterLocation.Header,
                    Description = "Please enter a valid token",
                    Name = "Authorization",
                    Type = SecuritySchemeType.Http,
                    BearerFormat = "JWT",
                    Scheme = "Bearer"
                });
                option.AddSecurityRequirement(new OpenApiSecurityRequirement
                    {
                        {
                            new OpenApiSecurityScheme
                            {
                                Reference = new OpenApiReference
                                {
                                    Type=ReferenceType.SecurityScheme,
                                    Id="Bearer"
                                }
                            },
                            new string[]{}
                        }
                    });
            });

            ////Threading
            //var timerInterval = TimeSpan.FromMinutes(1);

            //// Đăng ký OrderStatusUpdater với DI container với phạm vi Scoped
            //services.AddScoped<OrderStatusUpdater>(sp =>
            //{
            //    var timerInterval = TimeSpan.FromMinutes(1); // Cung cấp giá trị timerInterval ở đây
            //    var orderService = sp.GetRequiredService<IOrderService>();
            //    return new OrderStatusUpdater(timerInterval, orderService);
            //});



            //Sripe
            services.AddDistributedMemoryCache();
            StripeConfiguration.ApiKey = Configuration["Stripe:SecretKey"];

            services.AddRouting(options => options.LowercaseUrls = true);
            services.AddSession(options =>
            {
                options.IdleTimeout = TimeSpan.FromMinutes(30); // Thời gian phiên tồn tại
                options.Cookie.HttpOnly = true;
                options.Cookie.IsEssential = true; // Đảm bảo phiên là bắt buộc
            });
        }

        public async void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "Restaurant v1"));
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseCors("AllowAll");

            app.UseAuthentication();

            app.UseAuthorization();

            app.UseSession();

            app.UseStatusCodePages();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });

            //var orderStatusUpdater = app.ApplicationServices.GetRequiredService<OrderStatusUpdater>();
            //orderStatusUpdater.Start();
        }
    }
}