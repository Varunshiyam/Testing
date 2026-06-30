public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer numbers, String Lastname) {
        List<Contact> contactList = new List<Contact>();

        for (Integer i = 0; i < numbers; i++) {
            Contact cot = new Contact(
                FirstName = 'Test ' + i,
                LastName = Lastname
            );
            contactList.add(cot);
        }

        return contactList;
    }
}