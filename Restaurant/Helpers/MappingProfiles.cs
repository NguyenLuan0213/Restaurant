using AutoMapper;
using Restaurant.Dto;
using Restaurant.DTO;
using Restaurant.Models;
using Restaurant.Models.RestaurantModels;
using Restaurant.Models.Users;

namespace Restaurant_BE.Helper
{
    public class MappingProfiles : Profile
    {

        public MappingProfiles()
        {
            CreateMap<Restaurantsbr, RestaurantsbrDTO>();
            CreateMap<RestaurantsbrDTO, Restaurantsbr>();

            CreateMap<Table, TablesDTO>();
            CreateMap<TablesDTO, Table>();

            CreateMap<Menu, MenuDTO>();
            CreateMap<MenuDTO, Menu>();

            CreateMap<Promotion, PromotionsDTO>();
            CreateMap<PromotionsDTO, Promotion>();

            CreateMap<Bill, BillDTO>();
            CreateMap<BillDTO, Bill>();

            CreateMap<Menuitem, MenuItemDTO>();
            CreateMap<MenuItemDTO, Menuitem>();

            CreateMap<Order, OrderDTO>();
            CreateMap<OrderDTO, Order>();

            CreateMap<Order, OrderUpdateDTO>();
            CreateMap<OrderUpdateDTO, Order>();

            CreateMap<Comment, CommentDTO>();
            CreateMap<CommentDTO, Comment>();

            CreateMap<CommentForCustomerDTO, Comment>();
            CreateMap<Comment, CommentForCustomerDTO>();

            CreateMap<Mean, MeanDTO>();
            CreateMap<MeanDTO, Mean>();

            CreateMap<Meanitem, MeanItemDTO>();
            CreateMap<MeanItemDTO, Meanitem>();

            CreateMap<User, UsersDTO>();
            CreateMap<UsersDTO, User>();
        }
    }
}
