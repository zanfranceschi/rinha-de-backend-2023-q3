namespace RinhaBackEnd.Domain
{
    public class Stack : Notifiable<Notification>
    {
        protected Stack() { }
        public Stack(string nome)
        {
            Id = Guid.NewGuid();
            Nome = nome;
            var contract = new Contract<Notification>();
            contract.IsNotNullOrEmpty(Nome, nameof(Nome));
            AddNotifications(contract);
        }

        public Guid Id { get; private set; }
        public string Nome { get; private set; }
        public IReadOnlyCollection<PersonStack> PersonStacks { get; private set; }
    }
}
