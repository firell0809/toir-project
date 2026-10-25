using Microsoft.AspNetCore.Mvc;
using ToirApi.Common;
namespace ToirApi.Controllers;
[ApiController]
[Route("api/ping")]
public class PingController : ControllerBase
{
    [HttpGet]
    public ActionResult<ApiResponse<string>> Ping()
    {
        return Ok(ApiResponse<string>.Ok("pong", "API работает"));
    }
}