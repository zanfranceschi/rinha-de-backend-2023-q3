using Flunt.Notifications;

namespace RinhaBackEnd.Domain
{
    public class Stack : Notifiable<Notification>
    {
        public Stack(string nome)
        {
            Id = Guid.NewGuid();
            Nome = nome;
            var contract = new Contract<Notification>();
            contract.IsNotNullOrEmpty(Nome, nameof(Nome));
            AddNotifications(contract);
        }

        public Guid Id { get; set; }
        public string Nome { get; set; }
        public IReadOnlyCollection<PersonStack> PersonStacks { get; private set; }
    }
}
