using Microsoft.EntityFrameworkCore;
using Restaurant.Data;
using Restaurant.Models.RestaurantModels;

namespace Restaurant.Repository.Interfaces
{
    public class TablesRepository : ITablesRepository
    {
        private readonly RestaurantContext _context;

        public TablesRepository(RestaurantContext context)
        {
            _context = context;
        }

        public bool CreateTable(Table table)
        {
            try
            {
                _context.Tables.Add(table);
                return Save();
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool DeleteTable(int id)
        {
            var table = _context.Tables.FirstOrDefault(t => t.Id == id);
            if (table == null)
            {
                return false; // Không tìm thấy người dùng để xóa
            }
            try

            {
                _context.Tables.Remove(table);
                _context.SaveChanges();

                return true;
            }
            catch (Exception)
            {
                return false;
            }

        }

        public Table GetTable(int id)
        {
            return _context.Tables.Where(t => t.Id == id).FirstOrDefault();
        }

        public Table GetTableByNumber(int TableNumber)
        {
            return _context.Tables.Where(t => t.TableNumber == TableNumber).FirstOrDefault();
        }


        public Table GetTableBySeats(int seats)
        {
            return _context.Tables.Where(t => t.Seats == seats).FirstOrDefault();
        }

        public Table GetTableByStatus(string status)
        {
            return _context.Tables.Where(t => t.Status == status).FirstOrDefault();
        }

        public Table GetTableByWaiterId(Guid waiterId)
        {
            return _context.Tables.Where(t => t.IdWaiter == waiterId).FirstOrDefault();
        }

        public ICollection<Table> GetTables()
        {
            return _context.Tables.OrderBy(t => t.Id).ToList();
        }

        public ICollection<Table> GetTablesByRestaurantId(int restaurantId)
        {
            return _context.Tables.Where(t => t.RestaurantId == restaurantId).ToList();
        }

        public ICollection<Table> GetTablesByRestaurantIdAndStatus(int restaurantId, string status)
        {
            return _context.Tables
               .Where(t => t.RestaurantId == restaurantId && t.Status == status)
               .ToList();
        }

        public bool Save()
        {
            var saved = _context.SaveChanges();
            return saved >= 0 ? true : false;
        }

        public bool TableExists(int id)
        {
            return _context.Tables.Any(t => t.Id == id);
        }

        public bool UpdateTable(Table table)
        {
            try
            {
                var resultTable = _context.Tables.FirstOrDefault(t => t.Id == table.Id);

                if (resultTable != null)
                {
                    resultTable.TableNumber = table.TableNumber;
                    resultTable.RestaurantId = table.RestaurantId;
                    resultTable.Seats = table.Seats;
                    resultTable.Status = table.Status;
                    resultTable.IdWaiter = table.IdWaiter;

                    _context.SaveChanges();

                    return true;
                }

                return false;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
