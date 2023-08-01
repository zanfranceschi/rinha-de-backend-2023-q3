namespace RinhaBackEnd.Dtos.Response
{
    public class PersonResponse
    {
        public Guid Id { get; set; }
        public string Apelido { get; set; }
        public string Nome { get; set; }
        private string Nascimento { get; set; }
        public IEnumerable<string> Stack { get; set; }
    }
}
