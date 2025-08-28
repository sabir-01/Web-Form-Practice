using ApiUsingSql.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;

namespace ApiUsingSql.Controllers
{
    public class NewApiController : ApiController
    {
        practiceEntities db = new practiceEntities();


        //  https://localhost:44306/api/NewApi  for all records and (api/NewApi/2) for single record
        [System.Web.Http.HttpGet]
        public IHttpActionResult Index()
        {
            List<student> obj = db.students.ToList();
            return Ok(obj);
        }

        [System.Web.Http.HttpGet]
        public IHttpActionResult Index( int id)
        {
            var obj = db.students.Where(model => model.std_id == id).FirstOrDefault();
            return Ok(obj);
        }
    }
}