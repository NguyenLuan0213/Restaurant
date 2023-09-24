using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Restaurant.Converters;
using Restaurant.Data;
using Restaurant.Models.AuthenModel;
using Restaurant.Repository;
using Restaurant.Repository.Interfaces;
using Swashbuckle.AspNetCore.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
            services.AddScoped<IUsersRepository, UsersRepository>();


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
            services.AddMvc();

            // Cấu hình JWT
            services.Configure<AppSetting>(Configuration.GetSection("AppSettings"));

            var secretKey = Configuration["AppSettings:SecretKey"];
            var secretKeyBytes = Encoding.UTF8.GetBytes(secretKey);
            

            services.AddAuthentication(item =>
            {
                item.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                item.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            })
                
                .AddJwtBearer(opt =>
                {
                    opt.TokenValidationParameters = new TokenValidationParameters
                    {
                        //tự cấp token
                        ValidateIssuer = false,
                        ValidateAudience = false,

                        //ký vào token
                        ValidateIssuerSigningKey = true,
                        IssuerSigningKey = new SymmetricSecurityKey(secretKeyBytes),

                        ClockSkew = TimeSpan.Zero
                    };
                });
            //// Cấu hình CORS
            //services.AddCors(options =>
            //{
            //    options.AddPolicy("CorsPolicy", builder =>
            //    {
            //        builder.AllowAnyOrigin()
            //            .AllowAnyMethod()
            //            .AllowAnyHeader();
            //    });
            //});

            //services.AddAuthorization(options =>
            //{
            //    options.AddPolicy("ADMIN", policy => policy.RequireClaim("role", "ADMIN"));
            //    options.AddPolicy("CASHIER", policy => policy.RequireClaim("role", "CASHIER"));
            //    options.AddPolicy("CUSTOMER", policy => policy.RequireClaim("role", "CUSTOMER"));
            //});

            services.AddSwaggerGen(options =>
            {
                options.AddSecurityDefinition("oauth2", new OpenApiSecurityScheme
                {
                    Description = "Standard Authorization header using the Bearer scheme (\"bearer {token}\")",
                    In = ParameterLocation.Header,
                    Name = "Authorization",
                    Type = SecuritySchemeType.ApiKey
                });

                options.OperationFilter<SecurityRequirementsOperationFilter>();
            });

            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "MyWebApiApp", Version = "v1" });
            });


        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "MyWebApiApp v1"));
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthentication();

            app.UseAuthorization();

            app.UseStatusCodePages();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
