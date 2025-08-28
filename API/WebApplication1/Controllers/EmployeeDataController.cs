using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace WebApplication1.Controllers
{
    public class EmployeeDataController : ApiController
    {
      // local host for employee : https://localhost:44359/api/EmployeeData/GetEmployees
        private readonly string[] MyEmployee = { "sabir", "muti", "gul", "abrar" };

        [HttpGet]
        public string[] GetEmployees()
        {
            return MyEmployee;
        }


        //local host for id https://localhost:44359/api/EmployeeData/GetEmployeeByid?id=2
        [HttpGet]
        public string GetEmployeeByid(int id)
        {
            return MyEmployee[id];
        }




    }
}
