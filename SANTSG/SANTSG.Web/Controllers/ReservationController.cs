using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using SANTSG.Web.Models;


namespace SANTSG.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReservationController : ControllerBase
    {
        private readonly IWebHostEnvironment _hostingEnvironment;


        public ReservationController(IWebHostEnvironment hostingEnvironment)
        {
            _hostingEnvironment = hostingEnvironment;
        }

        // GET: api/reservation
        [HttpGet]
        public IEnumerable<RezervationCard> Get()
        {
            List<RezervationCard> rezervationCards = new List<RezervationCard>();

            var rezervationCard = new RezervationCard
            {
                Operator = new TourOperator("AMOR", "AMOR REISE GMBH"),
                VoucherNo = 1
            };

            rezervationCards.Add(rezervationCard);

            return rezervationCards.ToList();
        }


        private const string FILE_NAME = "log.txt";

        // GET api/reservation/5
        [HttpGet("{id}", Name = nameof(GetReservation))]
        public IActionResult GetReservation(string id)
        {

            //if (System.IO.File.Exists(FILE_NAME))
            //{
            //    using (StreamWriter w = System.IO.File.AppendText("log.txt"))
            //    {
            //        ReservationController.Log(id.ToString(), w);
            //    }
            //    //_logger.LogInformation($"{FILE_NAME} zaten var!");

            //    return Ok(new
            //    {
            //        value = id + "merhaba"
            //    });



            //} else
            //{
            //    //_logger.LogInformation($"{FILE_NAME} yok!");

            //    return NotFound(new
            //    {
            //        value = $"{FILE_NAME} yok!"
            //    });
            //}

            return new OkObjectResult($"{id}");


        }

        // POST api/values
        [HttpPost]
        public IActionResult Post([FromBody]object reservation)
        {

            if (reservation == null)
            {
                return BadRequest("Lütfen POST istegini method body içerisinde gönderiniz.");
            }

            //TODO: Projenin klasör dizinini al
            string webRootPath = _hostingEnvironment.WebRootPath;
            string contentRootPath = _hostingEnvironment.ContentRootPath;
            string fileName = @"reservationFile.txt";

            string reservationFilePath = Path.Combine(contentRootPath, "reservationFiles");
            string combinePath = Path.Combine(reservationFilePath, fileName);

            //TODO: reservationFiles adında bir klasör var mı kontrol et!
            bool exists = System.IO.Directory.Exists(reservationFilePath);
            //TODO: Klasör Yok ise oluştur - Oluşturulamıyorsa hata dön!
            if (!exists)
                System.IO.Directory.CreateDirectory(reservationFilePath);

            //TODO: Klasör oluşturuldu ise içine dosyası reservationFile.txt oluştur!

            try
            {
                using (StreamWriter stream = new FileInfo(combinePath).AppendText())
                {
                    Log(this.ControllerContext.RouteData.Values["controller"].ToString(),
                        this.ControllerContext.RouteData.Values["action"].ToString(),
                        this.ControllerContext.HttpContext.Request.Method,
                        reservation,
                        stream);
                }
            }
            catch (UnauthorizedAccessException ex)
            {
                return BadRequest(ex);
            }

            return CreatedAtRoute(nameof(GetReservation), new { id = 1 }, new {
                contoller = this.ControllerContext.RouteData.Values["controller"].ToString(),
                action = this.ControllerContext.RouteData.Values["action"].ToString(),
                requestMethod = this.ControllerContext.HttpContext.Request.Method,
                json = reservation,
                success = true
            });
        }


        public static void Log(string controller,string action, string requestMethod, object message, StreamWriter sw)
            {
            sw.WriteLine("---------------------------------------");
            sw.WriteLine($"{DateTime.Now.ToLongTimeString()} - {DateTime.Now.ToLongDateString()}");
            sw.WriteLine($"Controller: {controller}");
            sw.WriteLine($"Action: {action}");
            sw.WriteLine($"Request Method: {requestMethod}");
            sw.WriteLine("---------------------------------------");
            sw.WriteLine(message);
            sw.WriteLine("---------------------------------------");
            sw.Flush();
        }
        }
    }
