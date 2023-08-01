namespace RinhaBackEnd.Dtos.Requests
{
    public class PersonRequest
    {
        public string Apelido { get; set; }
        public string Nome { get; set; }
        private string Nascimento { get; set; }
        public IEnumerable<string> Stack { get; set; }
    }
}
