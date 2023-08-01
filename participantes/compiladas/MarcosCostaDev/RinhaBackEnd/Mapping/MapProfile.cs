
using RinhaBackEnd.Domain;
using RinhaBackEnd.Dtos.Response;

namespace RinhaBackEnd.Mapping
{
    public class MapProfile : Profile
    {
        public MapProfile()
        {
            CreateMap<Person, PersonResponse>();
            CreateMap<Stack, string>()
                .ConvertUsing(p => p.Nome);
        }
    }
}
