using Flunt.Notifications;

namespace RinhaBackEnd.Domain
{
    public class PersonStack : Notifiable<Notification>
    {
        protected PersonStack() { }
        public PersonStack(Person person, Stack stack)
        {
            Person = person;
            Stack = stack;
            AddNotifications(Person);
            AddNotifications(Stack);
        }

        public Guid StackId { get; private set; }
        public Guid PersonId { get; private set; }

        public Person Person { get; private set; }
        public Stack Stack { get; private set; }
    }
}
