using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace Restaurant.Migrations
{
    /// <inheritdoc />
    public partial class InitRole : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "600dcb41-d6de-44cb-8cc8-21562844c564", "4", "WAITER", "WAITER" },
                    { "9bb1cda4-a489-4346-b983-bd43503607f4", "2", "CUSTORMER", "CUSTORMER" },
                    { "bc4a88c3-92d6-4272-95df-122523c7d0d2", "3", "CASHIER", "CASHIER" },
                    { "cf0b06de-0600-4d0d-b87d-00b9cf96f763", "1", "ADMIN", "ADMIN" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "600dcb41-d6de-44cb-8cc8-21562844c564");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "9bb1cda4-a489-4346-b983-bd43503607f4");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "bc4a88c3-92d6-4272-95df-122523c7d0d2");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "cf0b06de-0600-4d0d-b87d-00b9cf96f763");
        }
    }
}
